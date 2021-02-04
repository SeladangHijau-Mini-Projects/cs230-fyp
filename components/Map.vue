<template>
    <svg id="map" :height="height" :width="width"></svg>
</template>

<script>
// import * as d3 from 'd3';
// import * as d3Hexjson from 'd3-hexjson';

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
    data() {
        return {
            // d3 map
            svg: null,
        };
    },
};
</script>

<style scoped>
#map {
    border: 1px solid black;
}
</style>
