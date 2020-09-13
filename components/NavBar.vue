<template>
  <div id="navbar">
    <b-navbar toggleable="lg" type="dark" variant="dark">
      <!-- nav icon -->
      <b-navbar-brand href="/">NavBar</b-navbar-brand>

      <!-- collapsed menu on tablet screen or smaller -->
      <b-navbar-toggle target="nav-collapse"></b-navbar-toggle>

      <!-- nav buttons -->
      <b-collapse id="nav-collapse" is-nav>
        <b-navbar-nav>
          <b-nav-item href="/">Home</b-nav-item>
          <b-nav-item href="/about">About</b-nav-item>
        </b-navbar-nav>
      </b-collapse>
    </b-navbar>
  </div>
</template>

<script>
export default {
  name: 'NavBar',
  props: {},

  data() {
    return {}
  },
  methods: {},
}
</script>

<style scoped></style>
