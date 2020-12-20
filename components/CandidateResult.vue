<template>
    <b-container class="result" fluid>
        <b-card no-body class="overflow-hidden" style="max-width: 540px">
            <b-row no-gutters>
                <!-- party icon -->
                <b-col md="2">
                    <b-card-img
                        :src="partyIconSrc"
                        alt="Image"
                        class="rounded-0"
                    ></b-card-img>
                </b-col>

                <!-- chart -->
                <b-col md="10">
                    <b-card-body>
                        <!-- candidate vote info -->
                        <b-row class="candidate" align-v="end">
                            <b-col cols="8">
                                <h5 class="candidate-name">{{ name }}</h5>
                            </b-col>
                            <b-col cols="4">
                                <h6 class="candidate-vote">
                                    {{ vote }} / {{ voter }}
                                </h6>
                            </b-col>
                        </b-row>

                        <!-- vote chart -->
                        <b-row class="vote-chart">
                            <b-col cols="12">
                                <b-progress class="mt-2" :max="voter">
                                    <b-progress-bar
                                        :value="vote"
                                        :variant="progressBarVariant"
                                    ></b-progress-bar>
                                </b-progress>
                            </b-col>
                        </b-row>
                    </b-card-body>
                </b-col>
            </b-row>
        </b-card>
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
    margin: 5px;
}

.party-icon {
    border: none;
}
</style>
