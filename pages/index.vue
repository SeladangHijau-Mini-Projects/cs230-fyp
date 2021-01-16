<template>
    <b-container>
        <b-row class="map">
            <b-col>
                <MapViz />
            </b-col>
        </b-row>
    </b-container>
</template>

<script>
import MapViz from '../components/MapViz';

export default {
    components: { MapViz },
};
</script>

<style scoped>
.map {
    margin-top: 10px;
    margin-bottom: 10px;
}
</style>
