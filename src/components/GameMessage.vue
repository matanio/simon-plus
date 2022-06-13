<template>
  <!-- Popup Message -->
  <div class="text-blue-500 z-50 absolute grid font-bold content-center ml-10 m-auto text-2xl slide-in">
    {{text}}
  </div>
</template>


<script>

export default {
  name: 'GameMessage',  
  props: {
    text:{
      required: true,
      type: String,
    }
  }
}
</script>

<style scoped>
.slide-in {
  opacity: 0;
  animation: slide forwards 0.5s;
}
@keyframes slide {
  0% {
    opacity: 0;
    transform: translateY(10px);
  }

  to {
    opacity: 1;
    transform: translateY(0);
  }
}

</style>
