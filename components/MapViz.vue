<template>
    <div id="map"></div>
</template>

<script>
import * as d3 from 'd3';
// import * as d3Hexbin from 'd3-hexbin';

export default {
    name: 'MapViz',
    data() {
        return {
            width: 700,
            height: 500,
            padding: 100,
            hexagonRadius: 10,
            raceSetting: null,
            partySetting: null,
            stateSetting: null,
        };
    },

    async mounted() {
        await this.fetchData();
    },
    methods: {
        async fetchData() {
            this.raceSetting = await d3.json('./race.json');
            this.partySetting = await d3.json('./party.json');
            this.stateSetting = await d3.json('./state.json');
        },
    },
};
</script>

<style scoped></style>
