<template>
    <svg id="map" :viewBox="viewBox"></svg>
</template>

<script>
import * as d3 from 'd3';
import * as d3Hexjson from 'd3-hexjson';

export default {
    name: 'Map',
    props: {
        width: {
            default: 700,
            type: Number,
        },
        height: {
            default: 500,
            type: Number,
        },
        hexagonRadius: {
            default: 10,
            type: Number,
        },
        resultData: {
            required: true,
            type: Object,
        },
        stateSetting: {
            required: true,
            type: Object,
        },
        raceSetting: {
            required: true,
            type: Object,
        },
        partySetting: {
            required: true,
            type: Object,
        },
    },

    computed: {
        viewBox() {
            return `0 0 ${this.width} ${this.height}`;
        },
        svg() {
            return d3.select('#map');
        },
        hexList() {
            const hexJson = d3Hexjson.renderHexJSON(
                this.resultData,
                this.width,
                this.height,
            );

            return this.svg
                .selectAll('g')
                .data(hexJson)
                .enter()
                .append('g')
                .attr('cursor', 'pointer')
                .attr('transform', (hex) => `translate(${hex.x}, ${hex.y})`);
        },
    },

    mounted() {
        // TODO: find a way to not use mounted() function
        this.drawStateHex();
    },

    methods: {
        drawStateHex() {
            const _this = this;

            this.hexList
                .attr('class', 'state')
                .append('polygon')
                .attr('points', function (hex) {
                    return hex.points;
                })
                .attr('stroke', 'white')
                .attr('stroke-width', '2')
                .attr(
                    'fill',
                    (hex) => _this.partySetting[hex.result.partyId].color,
                );

            this.hexList
                .append('text')
                .attr('class', 'state-label')
                .attr('stroke', 'black')
                .attr('text-anchor', 'middle')
                .text((hex) => _this.stateSetting[hex.key].name);
        },
    },
};
</script>

<style scoped>
#map {
    border: 1px solid black;
}
</style>
