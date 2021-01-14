<template>
    <div>
        <svg id="map" :height="height" :width="width"></svg>

        <!-- TODO: make this as tooltip -->
        <StateTooltip
            id="state-tooltip"
            :style="'position: relative; opacity: ' + (showTooltip ? '1' : '0')"
            :candidate-result-list="candidateResultList"
        />
    </div>
</template>

<script>
import * as d3 from 'd3';
import * as d3Hexjson from 'd3-hexjson';
import { StateTooltip } from './StateTooltip';

export default {
    name: 'MapViz',
    components: { StateTooltip },
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

            candidateResultList: [],
            showTooltip: false,
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
            const _this = this;

            // Create the svg element
            this.svg = d3
                .select('#map')
                .attr('viewBox', [0, 0, this.width, this.height])
                .append('g');

            // draw state hexes
            this.stateHexList = this.initHex(
                this.svg,
                this.stateHexJson,
                this.width,
                this.height,
            );
            this.drawHex(this.stateHexList, _this.partySetting, 'state');
            this.drawHexLabel(this.stateHexList);
            this.initStateTooltip();

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
                funcDrawHex(
                    parliamentHexList,
                    _this.partySetting,
                    'parliament',
                );
                funcDrawHexLabel(parliamentHexList);

                parliamentHexList.on(
                    'click',
                    (parliamentEvent, parliamentKey) => {
                        // TODO: parliament tooltip
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
        initStateTooltip() {
            const _this = this;
            const stateTooltip = d3.select('#state-tooltip');

            d3.selectAll('.state')
                .on('mouseover', function (hex, data) {
                    const result = data.result;

                    _this.candidateResultList.push({
                        name: result.candidateName,
                        partyId: result.partyId,
                        partyIcon: '',
                        voter: result.voterNo,
                        vote: result.voteNo,
                    });
                    _this.showTooltip = true;

                    return stateTooltip.style('visibility', 'visible');
                })
                .on('mouseout', function (d) {
                    _this.candidateResultList.splice(
                        0,
                        _this.candidateResultList.length,
                    );
                    _this.showTooltip = false;

                    return stateTooltip.style('visibility', 'hidden');
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
