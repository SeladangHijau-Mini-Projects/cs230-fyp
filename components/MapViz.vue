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
            hexagonRadius: 10,
            width: 500,
            height: 700,
            raceSetting: null,
            partySetting: null,
            stateSetting: null,
            hexJson: null,
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
            this.stateHexjson = await d3.json('./state.hexjson');
        },
        drawMap() {
            const partySetting = this.partySetting;

            // Create the svg element
            const svg = d3
                .select('#map')
                .attr('viewBox', [0, 0, this.width, this.height])
                .append('g');

            // Render state hexes
            const stateHexes = d3Hexjson.renderHexJSON(
                this.stateHexjson,
                this.width,
                this.height,
            );

            // Bind the hexes to g elements of the svg and position them
            const stateHexmap = svg
                .selectAll('g')
                .data(stateHexes)
                .enter()
                .append('g')
                .attr('transform', function (hex) {
                    return 'translate(' + hex.x + ',' + hex.y + ')';
                })
                .on('click', function (event, hex) {});

            // Draw hex polygons
            stateHexmap
                .append('polygon')
                .attr('points', function (hex) {
                    return hex.points;
                })
                .attr('stroke', 'white')
                .attr('stroke-width', '2')
                .attr('fill', function (hex) {
                    const winningPartyId = hex.result.partyId;
                    return partySetting[winningPartyId].color;
                });

            // Add labels to hex polygon
            stateHexmap
                .append('text')
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

<style scoped></style>
