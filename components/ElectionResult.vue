<template>
    <b-container class="result" fluid>
        <h3>Election Result</h3>
        <CandidateResult
            v-for="(candidate, index) in candidateResultList"
            :key="index"
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
    name: 'ElectionResult',
    components: [CandidateResult],
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

<style scoped></style>
