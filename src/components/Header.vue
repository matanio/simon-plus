<template>
  <div class="text-white bg-red-500 h-64 grid content-center gap-4 text-center slide-in slide-in-global">
      <div class="text-6xl font-semibold p-3">Simon+</div>
      <p>An app based on the game Simon.</p>
      <p>🧠</p>
  </div>
</template>

<script>

export default {
  name: 'Header',
}
</script>

<style>
.slide-in-global {
  opacity: 0;
  animation: slide forwards 0.8s;
}
@keyframes slide {
  0% {
    opacity: 0;
    transform: translateY(15px);
  }

  to {
    opacity: 1;
    transform: translateY(0);
  }
}

</style>
