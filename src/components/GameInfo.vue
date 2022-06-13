
<template>
 <div :class="(modeColor=='again')? 'border-red-400 bg-red-500' : 'border-blue-400 bg-blue-500'" class="opacity-100 z-50 border-4  border-gray-400 rounded-lg  m-auto  w-64 h-32 grid grid-rows-4 transition-colors  ">
    <div :class="(modeColor=='again')? 'border-red-400 text-red-500' : 'border-blue-400 text-blue-500'" class="border-4  font-bold text-2xl text-center m-auto  -mt-4 rounded w-3/4 bg-white">
      {{title}}
    </div>
    <div class="text-lg text-white text-center m-auto">
      {{info}}
    </div>
    <div @click="$emit('clicked')" :class="(modeColor=='again')? ' text-red-500' : 'text-blue-500'" class="row-span-2 transition-colors rounded w-2/3 bg-white text-center m-auto text-white font-bold hover:text-gray-400 btn text-xl" >
      {{buttonText}}
    </div>
</div>
</template>


<script>

export default {
  name: 'GameInfo',  
  props: {
    title: String,
    info: String,
    buttonText: String,
    modeColor: String,
  },
}
</script>

<style scoped>
.btn:hover {
  box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.2);
}
</style>