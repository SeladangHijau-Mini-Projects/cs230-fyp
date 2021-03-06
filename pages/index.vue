<template>
    <b-container>
        <b-row class="map">
            <b-col>
                <Map
                    :election-result="electionResult"
                    :state-setting="stateSetting"
                    :race-setting="raceSetting"
                    :party-setting="partySetting"
                />
            </b-col>
        </b-row>
    </b-container>
</template>

<script>
import raceSettingData from '../static/race.json';
import partySettingData from '../static/party.json';
import stateSettingData from '../static/state.json';
import electionResultData from '../static/result.json';
import { Map } from '../components/Map';

export default {
    components: { Map },
    data() {
        return {
            electionResult: electionResultData,
            raceSetting: raceSettingData,
            partySetting: partySettingData,
            stateSetting: stateSettingData,
        };
    },
};
</script>

<style scoped>
.map {
    margin-top: 10px;
    margin-bottom: 10px;
}
</style>
