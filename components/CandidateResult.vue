<template>
    <b-container class="result" fluid>
        <!-- candidate vote info -->
        <b-row class="candidate" align-v="end">
            <b-col v-if="partyIconSrc" cols="3">
                <b-img-lazy
                    v-bind="{
                        center: true,
                        fluidGrow: true,
                        blank: true,
                        blankColor: '#bbb',
                    }"
                    :src="partyIconSrc"
                    class="party-icon"
                    width="500"
                    height="500"
                    thumbnail
                    fluid
                ></b-img-lazy>
            </b-col>
            <b-col cols="6">
                <h5 class="candidate-name">{{ name }}</h5>
            </b-col>
            <b-col cols="3">
                <h6 class="candidate-vote">{{ vote }} / {{ voter }}</h6>
            </b-col>
        </b-row>

        <!-- vote chart -->
        <b-row class="vote-chart">
            <b-col>
                <b-progress class="mt-2" :max="voter">
                    <b-progress-bar
                        :value="vote"
                        :variant="progressBarVariant"
                    ></b-progress-bar>
                </b-progress>
            </b-col>
        </b-row>
    </b-container>
</template>

<script>
export default {
    name: 'CandidateResult',
    props: {
        partyColor: {
            type: String,
            required: false,
            default: 'green',
        },
        partyIconSrc: {
            type: String,
            required: false,
            default: null,
        },
        name: {
            type: String,
            required: true,
        },
        vote: {
            type: Number,
            required: true,
        },
        voter: {
            type: Number,
            required: true,
        },
    },

    computed: {
        progressBarVariant() {
            let variant = 'success';

            switch (this.partyColor) {
                case 'green':
                    variant = 'success';
                    break;
                case 'red':
                    variant = 'danger';
                    break;
                case 'yellow':
                    variant = 'warning';
                    break;
                case 'blue':
                    variant = 'primary';
                    break;
                case 'grey':
                    variant = 'secondary';
                    break;
            }

            return variant;
        },
    },
};
</script>

<style scoped>
.result {
    width: 400px;
}

.party-icon {
    border: none;
}
</style>
