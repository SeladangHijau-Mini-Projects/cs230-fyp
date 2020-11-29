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

            // d3 map
            svg: null,
            stateHexList: [],
        };
    },

    async mounted() {
        await this.fetchData();
        this.drawMap();
        this.drawStateHex();
    },
    methods: {
        async fetchData() {
            this.raceSetting = await d3.json('./race.json');
            this.partySetting = await d3.json('./party.json');
            this.stateSetting = await d3.json('./state.json');
            this.stateHexjson = await d3.json('./state.hexjson');
        },
        drawMap() {
            // Create the svg element
            this.svg = d3
                .select('#map')
                .attr('viewBox', [0, 0, this.width, this.height])
                .append('g');
        },
        drawStateHex() {
            // declare state hexes
            const stateHexJson = d3Hexjson.renderHexJSON(
                this.stateHexjson,
                this.width,
                this.height,
            );

            // initialize state hexes
            this.stateHexList = this.svg
                .selectAll('g')
                .data(stateHexJson)
                .enter()
                .append('g')
                .attr('cursor', 'pointer')
                .attr('transform', function (hex) {
                    return `translate(${hex.x}, ${hex.y})`;
                })
                .on('click', function (event, hex) {});

            // draw state hex polygons
            const partySettingList = this.partySetting;
            this.stateHexList
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

            // Add labels to hex polygon
            this.stateHexList
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
