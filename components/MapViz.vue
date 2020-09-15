<template>
  <div id="map"></div>
</template>

<script>
import * as d3 from 'd3';
import * as d3Hexbin from 'd3-hexbin';

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
      `${this.baseUrl}${this.raceEndpoint}`
    ).then((res) => res.json());
    this.partySetting = await fetch(
      `${this.baseUrl}${this.partyEndpoint}`
    ).then((res) => res.json());
    this.electionStates = await fetch(
      `${this.baseUrl}${this.stateEndpoint}`
    ).then((res) => res.json());
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
    };
  },
  mounted() {
    const hexbin = d3Hexbin.hexbin().radius(this.hexagonRadius);
    const svg = d3
      .select('#map')
      .append('svg')
      .attr('width', this.width)
      .attr('height', this.height);
    const stateList = this.electionStates;
    const parliamentCoordinateList = this.electionStates.reduce(
      (acc, state) => {
        acc.push(
          Object.values(state.parliaments).reduce((acc2, parliament) => {
            acc2.push([parliament.coordinate.x, parliament.coordinate.y]);

            return acc2;
          }, [])
        );

        return acc;
      },
      []
    );

    const g = svg.selectAll('g').data(stateList);

    g.enter()
      .append('g')
      .attr('class', 'state')
      .attr('id', (d, i) => {
        return stateList[i].id;
      })
      .style('fill', (d, i) => {
        return stateList[i].color;
      })
      .style('stroke', (d, i) => {
        return stateList[i].color;
      })
      .on('click', (d, i, j) => {})
      .selectAll('.parliament')
      .data((d, i) => {
        return hexbin(parliamentCoordinateList[i]);
      })
      .enter()
      .append('path')
      .attr('class', 'parliament')
      .attr('id', (d, i) => {
        console.log(this); // TODO: debug error here (cannot get index of parent node)
        console.log(this.parentNode);
        const j = +this.parentNode.getAttribute('data-index');
        console.log(stateList[j]);
        return Object.keys(stateList[j].parliaments)[i];
      })
      .attr('d', (d) => {
        return (
          'M' +
          (d.x + this.padding) +
          ',' +
          (d.y + this.padding) +
          hexbin.hexagon()
        );
      });
  },
};
</script>

<style scoped></style>
