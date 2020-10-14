<template>
    <svg id="map" height="500" width="700"></svg>
</template>

<script>
import * as d3 from 'd3';
import * as d3Hexjson from 'd3-hexjson';

export default {
    name: 'MapViz',
    data() {
        return {
            padding: 100,
            hexagonRadius: 10,
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

            // Set the size and margins of the svg
            const margin = { top: 10, right: 10, bottom: 10, left: 10 };
            const width = 500 - margin.left - margin.right;
            const height = 420 - margin.top - margin.bottom;

            // Create the svg element
            const svg = d3
                .select('#map')
                .append('svg')
                .attr('width', width + margin.left + margin.right)
                .attr('height', height + margin.top + margin.bottom)
                .append('g')
                .attr(
                    'transform',
                    'translate(' + margin.left + ',' + margin.top + ')',
                );

            // Render state hexes
            const stateHexes = d3Hexjson.renderHexJSON(
                this.stateHexjson,
                width,
                height,
            );

            // Bind the hexes to g elements of the svg and position them
            const stateHexmap = svg
                .selectAll('g')
                .data(stateHexes)
                .enter()
                .append('g')
                .attr('transform', function (hex) {
                    return 'translate(' + hex.x + ',' + hex.y + ')';
                });

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

            // Add labels
            stateHexmap
                .append('text')
                .append('tspan')
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
