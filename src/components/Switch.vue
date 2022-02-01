<template>
  <div class="p-2 flex items-center justify-center  ">
    <input :checked="isChecked" @change="$emit('checked')" class="switch appearance-none w-9 rounded-full h-5 bg-white bg-no-repeat bg-contain bg-gray-300 focus:outline-none cursor-pointer shadow-sm" type="checkbox" role="switch" id="switch">
</div>

</template>


<script>

export default {
  name: 'switch',  
  props: {
    isChecked: Boolean
  },
}
</script>

<style scoped>
.switch {
    background-image: url('../img/circle.svg');
    background-position: 0;
    transition: background-position .15s ease-in-out;
}

.switch:checked {
    background-position: 100%;
    background-color: theme('colors.red.500')
}

</style>