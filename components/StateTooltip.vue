<template>
    <b-container class="result" fluid>
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
    </b-container>
</template>

<script>
import { CandidateResult } from './CandidateResult';

export default {
    name: 'StateTooltip',
    components: { CandidateResult },
    props: {
        candidateResultList: {
            type: Array,
            required: true,
        },
    },

    methods: {
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
.state-tooltip {
    margin: 5px;
}
</style>
