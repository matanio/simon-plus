<template>
<div class="text-center">
    <label for="mode">Mode:</label>
    <select name="mode" @change="buildTiles()" id="" v-model="numberOfTiles">
        <option value="4">Easy - 4</option>
        <option value="6">Medium - 6</option>
        <option value="8">Hard- 8</option>
 
    </select>
</div>
<div v-if="!isPlaying"  class="font-bold text-white rounded-md bg-red-500 w-32 mb-5 hover:bg-red-600" @click="startGame()">
    PLAY GAME
</div>
  <div class="grid grid-cols-2 gap-3 w-1/2 m-auto mb-5">
      <div v-for="tile in tiles" :key="tile"><button @click="clickTile(tile)" :id=" 'tile_' + tile" :disabled="disabled" class="shadow-lg w-full border-4 border-transparent rounded-md p-5 transition-colors hover:opacity-80" :class="colors[tile-1]" > </button></div>
  </div>
  <div v-if="isOver">
    GAME OVER
</div>
<audio id="soundC" src="./C.mp3" autoplay="true"></audio>
</template>
 
<script>
export default {
  name: 'Game',
  data() {
      return {
          tiles: [1, 2, 3, 4],
          numberOfTiles: 4,
          generatedSequence: [],
          count: 0,
          colors: ["bg-green-500","bg-red-600", "bg-yellow-400", "bg-blue-700", "bg-purple-700", "bg-pink-700"],
          flashColors: ["bg-green-200","bg-red-300", "bg-yellow-100", "bg-blue-400", "bg-purple-400", "bg-pink-400"],
          disabled: false,
          isPlaying: false,
          isOver: false,
          sounds: ['C', 'D', 'E', 'F', 'G', 'A', 'B', 'C2']
      }
  },
  methods: {
    async flashTile(tile){
        console.log(tile);
        let tile_to_flash = document.getElementById(`tile_${tile}`) ;
        let flashColorIndex = tile-1;
        console.log(this.colors[flashColorIndex])
        tile_to_flash.classList.remove(this.colors[flashColorIndex]);
        tile_to_flash.classList.add(this.flashColors[flashColorIndex]);
        console.log(tile_to_flash.classList)
        await this.sleep(500);
        tile_to_flash.classList.remove(this.flashColors[flashColorIndex]);
        tile_to_flash.classList.add(this.colors[flashColorIndex]);
 
    },
    startGame() {
        // Function which adds, ready? and fades away button
        this.disabled = true;
        this.isPlaying = true;
        this.playSequence();
    },
    async playSequence(){
        console.log('played')
        let randChoice = Math.floor(Math.random() * this.numberOfTiles) + 1;
        this.generatedSequence.push(randChoice)
        for (let index = 0; index < this.generatedSequence.length; index++) {
            await this.sleep(1000);
            this.flashTile(this.generatedSequence[index]);
        }
        this.count = 0;
        this.disabled = false;
    },
    clickTile(tile) {
        console.log(this.count);
        console.log(this.generatedSequence)
        if(tile == this.generatedSequence[this.count]){
            if(this.count + 1 == this.generatedSequence.length){
                console.log('NICE')
                this.disabled = true;
                this.playSequence();
            } else {
                this.count++;
            }
        } else {
            console.log("WE GOT IT WRONG")
            this.generatedSequence = []
            this.disabled = true;
            this.isPlaying = false;
            this.isOver = true;
        }
    },
    buildTiles() {
        this.tiles = [];
        for (let index = 0; index < this.numberOfTiles; index++) {
            this.tiles[index] = index+1;
           
        }
    },
    sleep(ms) {
     return new Promise((resolve) => {
        setTimeout(resolve, ms);
     });
    },
 
 
  }
}
</script>
 
<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
 
</style>
 
