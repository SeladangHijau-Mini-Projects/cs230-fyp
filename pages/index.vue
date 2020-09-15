<template>
  <div class="container">
    <MapViz :width="700" :height="500" :padding="100" :hexagon-radius="10" />
    <h1>Home</h1>
  </div>
</template>

<script>
import MapViz from '../components/MapViz'

export default {
  components: [MapViz],
}
</script>

<style></style>
