<template>
  <div id="map"></div>
</template>

<script>
export default {
  name: 'MapViz',
  props: {
    width: {
      type: Number,
      required: true,
    },
    height: {
      type: Number,
      required: true,
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
      `${this.baseUrl}${this.raceEndpoint}`
    ).then((res) => res.json())
    this.partySetting = await fetch(
      `${this.baseUrl}${this.partyEndpoint}`
    ).then((res) => res.json())
    this.electionStates = await fetch(
      `${this.baseUrl}${this.stateEndpoint}`
    ).then((res) => res.json())
  },
  data() {
    return {
      baseUrl: process.env.BACKEND_SERVICE_URL || 'http://localhost:3000',
      raceEndpoint: '/races',
      partyEndpoint: '/parties',
      stateEndpoint: '/states',
      raceSetting: null,
      partySetting: null,
      electionStates: null,
    }
  },
  methods: {
    init() {},
  },
}
</script>

<style scoped></style>
