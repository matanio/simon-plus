<template>
  <Header />
    <div class="min-h-screen md:container md:mx-auto mt-1 md:mt-5">
      <main-menu />
    </div>
  <Footer />
</template>

<script>
import Header from './components/Header.vue'
import Footer from './components/Footer.vue'
import MainMenu from './components/MainMenu.vue'

export default {
  name: 'App',
  components: {
    Header, Footer, MainMenu,
  }
}
</script>

<style>
#app {
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  background-color: rgb(240, 240, 240);
}

</style>
