<template>
    <div id="map"></div>
</template>

<script>
// import * as d3 from 'd3';
// import * as d3Hexbin from 'd3-hexbin';

export default {
    name: 'MapViz',
    props: {
        width: {
            type: Number,
            default: 700,
        },
        height: {
            type: Number,
            default: 500,
        },
        padding: {
            type: Number,
            default: 100,
        },
        hexagonRadius: {
            type: Number,
            default: 10,
        },
    },
    async fetch() {
        this.raceSetting = await fetch(
            'http://localhost:3000/race.json',
        ).then((res) => res.json());
        this.partySetting = await fetch(
            'http://localhost:3000/party.json',
        ).then((res) => res.json());
        this.stateSetting = await fetch(
            'http://localhost:3000/state.json',
        ).then((res) => res.json());
    },

    data() {
        return {
            raceSetting: null,
            partySetting: null,
            stateSetting: null,
        };
    },
    mounted() {},
};
</script>

<style scoped></style>
