<template>
    <b-container fluid>
        <b-row>
            <b-col md="8">
                <svg id="map" :height="height" :width="width"></svg>
            </b-col>
            <b-col md="4">
                <CandidateResult
                    v-for="(candidate, index) in candidateResultList"
                    :key="index"
                    class="candidate-result"
                    :name="candidate.name"
                    :party-color="partyColor(candidate.partyId)"
                    :party-icon-src="candidate.partyIcon"
                    :voter="candidate.voter"
                    :vote="candidate.vote"
                />
            </b-col>
        </b-row>
    </b-container>
</template>

<script>
import * as d3 from 'd3';
import * as d3Hexjson from 'd3-hexjson';
import { CandidateResult } from './CandidateResult';

export default {
    name: 'MapViz',
    components: { CandidateResult },
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

            // draw parliament hex on state click
            this.stateHexList.on('click', (event, hex) => {
                // clear state hexes
                d3.selectAll('.state').remove();

                const parliamentHexList = _this.initHex(
                    _this.svg,
                    _this.stateHexJson.hexes[hex.key].parliament,
                    _this.width,
                    _this.height,
                );
                _this.drawHex(
                    parliamentHexList,
                    _this.partySetting,
                    'parliament',
                );

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
            const _this = this;

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
                })
                .on('mouseover', function (hex, data) {
                    const result = data.result;

                    // TODO: need to show correct data
                    _this.candidateResultList = [
                        {
                            name: result.candidateName,
                            partyId: result.partyId,
                            partyIcon: result.partyId
                                ? _this.partySetting[result.partyId].iconUrl
                                : _this.partySetting.others.iconUrl,
                            voter: result.voterNo,
                            vote: result.voteNo,
                        },
                    ];
                });
            hexList
                .append('text')
                .attr('class', 'label-state')
                .attr('stroke', 'black')
                .attr('stroke-width', '1')
                .attr('text-anchor', 'middle')
                .text(function (hex) {
                    return hex.label;
                });

            if (className) {
                hexList.attr('class', className);
            }
        },
        partyColor(partyId) {
            let color = 'green';

            switch (partyId) {
                case 'pas':
                    color = 'green';
                    break;
                case 'bn':
                    color = 'blue';
                    break;
                case 'dap':
                    color = 'red';
                    break;
                case 'others':
                    color = 'grey';
                    break;
            }

            return color;
        },
    },
};
</script>

<style scoped>
#map {
    border: 1px solid black;
}
</style>
