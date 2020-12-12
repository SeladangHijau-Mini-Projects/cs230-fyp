<template>
    <div class="container">
        <MapViz />
        <ElectionResult
            :candidate-result-list="[
                {
                    name: 'Candidate 1',
                    partyId: 'pas',
                    partyIcon:
                        'https://upload.wikimedia.org/wikipedia/commons/f/f0/PAS_logo.svg',
                    vote: 70,
                    voter: 100,
                },
                {
                    name: 'Candidate 2',
                    partyId: 'dap',
                    partyIcon:
                        'https://dapmalaysia.org/en/wordpress/wp-content/uploads/2013/06/dap_rocket_logo.gif',
                    vote: 20,
                    voter: 100,
                },
                {
                    name: 'Candidate 3',
                    partyId: 'bn',
                    partyIcon:
                        'https://upload.wikimedia.org/wikipedia/en/f/fe/Barisan_Nasional_Logo.svg',
                    vote: 5,
                    voter: 100,
                },
                {
                    name: 'Candidate 4',
                    partyId: 'others',
                    vote: 5,
                    voter: 100,
                },
            ]"
        />
    </div>
</template>

<script>
import MapViz from '../components/MapViz';
import { ElectionResult } from '../components/ElectionResult';

export default {
    components: { MapViz, ElectionResult },
};
</script>

<style></style>
