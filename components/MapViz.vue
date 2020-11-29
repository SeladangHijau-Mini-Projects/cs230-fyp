<template>
    <svg id="map" :height="height" :width="width"></svg>
</template>

<script>
import * as d3 from 'd3';
import * as d3Hexjson from 'd3-hexjson';

export default {
    name: 'MapViz',
    data() {
        return {
            // config
            width: 700,
            height: 500,
            hexagonRadius: 10,
            raceSetting: null,
            partySetting: null,
            stateSetting: null,
            stateHexJson: null,

            // d3 map
            svg: null,
            stateHexList: [],
        };
    },

    async mounted() {
        await this.fetchData();
        this.drawMap();
    },
    methods: {
        async fetchData() {
            this.raceSetting = await d3.json('./race.json');
            this.partySetting = await d3.json('./party.json');
            this.stateSetting = await d3.json('./state.json');
            this.stateHexJson = await d3.json('./state.hexjson');
        },
        drawMap() {
            // Create the svg element
            this.svg = d3
                .select('#map')
                .attr('viewBox', [0, 0, this.width, this.height])
                .append('g');

            // draw state hexes
            const partySettingList = this.partySetting;

            this.stateHexList = this.initHex(
                this.svg,
                this.stateHexJson,
                this.width,
                this.height,
            );
            this.drawHex(this.stateHexList, partySettingList, 'state');
            this.drawHexLabel(this.stateHexList);

            // draw parliament hex on state click
            const tempSvg = this.svg;
            const tempWidth = this.width;
            const tempHeight = this.height;
            const tempStateHexJsonData = this.stateHexJson;
            const funcInitHex = this.initHex;
            const funcDrawHex = this.drawHex;
            const funcDrawHexLabel = this.drawHexLabel;

            this.stateHexList.on('click', (event, hex) => {
                // clear state hexes
                d3.selectAll('.state').remove();

                const parliamentHexList = funcInitHex(
                    tempSvg,
                    tempStateHexJsonData.hexes[hex.key].parliament,
                    tempWidth,
                    tempHeight,
                );
                funcDrawHex(parliamentHexList, partySettingList, 'parliament');
                funcDrawHexLabel(parliamentHexList);

                parliamentHexList.on(
                    'click',
                    (parliamentEvent, parliamentKey) => {
                        console.log('parliamnentKey: ', parliamentKey);
                    },
                );
            });
        },
        initHex(svg, hexJsonData, width, height) {
            // declare state hexes
            const hexJson = d3Hexjson.renderHexJSON(hexJsonData, width, height);

            return svg
                .selectAll('g')
                .data(hexJson)
                .enter()
                .append('g')
                .attr('cursor', 'pointer')
                .attr('transform', function (hex) {
                    return `translate(${hex.x}, ${hex.y})`;
                });
        },
        drawHex(hexList, partySettingList, className = null) {
            hexList
                .append('polygon')
                .attr('points', function (hex) {
                    return hex.points;
                })
                .attr('stroke', 'white')
                .attr('stroke-width', '2')
                .attr('fill', function (hex) {
                    const winningPartyId = hex.result.partyId;
                    return partySettingList[winningPartyId].color;
                });

            // TODO: show tooltip on mouse over
            hexList
                .on('mouseover', function (d) {
                    console.log('(on enter) d: ', d);
                })
                .on('mouseout', function (d) {
                    console.log('(on exit) d: ', d);
                });

            if (className) {
                hexList.attr('class', className);
            }
        },
        drawHexLabel(hexList) {
            hexList
                .append('text')
                .attr('class', 'label-state')
                .attr('stroke', 'black')
                .attr('stroke-width', '1')
                .attr('text-anchor', 'middle')
                .text(function (hex) {
                    return hex.label;
                });
        },
    },
};
</script>

<style scoped>
#map {
    border: 1px solid black;
}
</style>
