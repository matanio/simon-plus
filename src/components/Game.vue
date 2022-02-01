<template>
<div class="relative">
    <game-message v-if="this.showGameMessage" :text="this.message" />
    <div v-if="!this.isPlaying" class="z-30 absolute content-center align-center bg-white border-4 w-full h-full rounded grid " :class="firstTime ? 'border-blue-500' : 'border-red-500'">
    <game-info :buttonText="firstTime ? 'START' : 'PLAY AGAIN'" :info="firstTime ? '🤔🧠💭' : 'SCORE: ' + this.score " :title="firstTime ? 'Ready?' : 'Game Over'" v-on:clicked="startGame()" :modeColor="firstTime ? 'new' : 'again'"/>
    </div>
    <ul class="grid grid-cols-4 text-gray-400 font-bold">
            <li class="text-left text-md md:text-2xl ">
              <div
                @click="soundToggle()"
                v-if="sound"
              >
                🔉
              </div>
              <div @click="soundToggle()" v-else>🔇</div>
            </li>
            <li class="text-sm md:text-lg text-left md:text-right content-center">SCORE: {{this.score}}</li>
            <li class="col-span-2 text-sm md:text-lg text-right">HIGHSCORE: {{highScore}}</li>
          </ul>

  <div id="tile-grid" class= "grid grid-cols-2 gap-3 w-9/10 m-auto mb-5">
      <div v-for="tile in tiles" :key="tile"><button @click="clickTile(tile)" :id=" 'tile_' + tile" :disabled="disabled" class="shadow-lg w-full h-32 border-4 border-transparent rounded-md p-5 transition-colors hover:opacity-80" :class="colors[tile-1]" > </button></div>
  </div>
<audio id="soundC" src="./C.mp3" autoplay="true"></audio>
</div>

</template>
 
<script>
import GameInfo from './GameInfo.vue'
import GameMessage from './GameMessage.vue'
import * as Tone from 'tone'
const synth = new Tone.Synth().toDestination();

export default {
  name: 'Game',
  props:{
      tileNum: Number, 
      sound: Boolean,
      highScore: Number,
  },
  components: {
      GameInfo, GameMessage
  },
 
  created() {
        this.buildTiles();
        this.message = this.messages[this.generateRandArrIndex(this.messages)];
  },
  data() {
      return {
          tiles: [1, 2, 3, 4],
          numberOfTiles: this.tileNum,
          generatedSequence: [],
          count: 0,
          colors: ["bg-green-500","bg-red-600", "bg-yellow-400", "bg-blue-700", "bg-purple-700", "bg-orange-600", "bg-gray-400", "bg-pink-900"],
          flashColors: ["bg-green-200","bg-red-300", "bg-yellow-100", "bg-blue-400", "bg-purple-400", "bg-orange-300", "bg-gray-100", "bg-pink-600"],
          disabled: false,
          isPlaying: false,
          notes: ['C3', 'D3', 'E3', 'F3', 'G3', 'A3', 'B3', 'C4'], 
          firstTime: true,
          score: 0,
        showGameMessage: false,
        message: '',
        messages: ['Nice!', 'Great!', 'Keep it up!', 'Awesome!']
      }
  },
  methods: {
    async flashTile(tile){
        let tile_to_flash = document.getElementById(`tile_${tile}`) ;
        let flashColorIndex = tile-1;
        tile_to_flash.classList.remove(this.colors[flashColorIndex]);
        tile_to_flash.classList.add(this.flashColors[flashColorIndex]);
        this.playNote(tile);
        await this.sleep(500);
        tile_to_flash.classList.remove(this.flashColors[flashColorIndex]);
        tile_to_flash.classList.add(this.colors[flashColorIndex]);
 
    },
    startGame() {
        // Function which adds, ready? and fades away button
        this.$emit('togglePlayStarted');
        this.disabled = true;
        this.isPlaying = true;
        this.firstTime = false;
        this.score = 0;
        this.playSequence();
    },
    async playSequence(){
        let randChoice = Math.floor(Math.random() * this.numberOfTiles) + 1;
        this.generatedSequence.push(randChoice)
        for (let index = 0; index < this.generatedSequence.length; index++) {
            await this.sleep(1000);
            this.flashTile(this.generatedSequence[index]);
        }
        this.removePointerEvents("tile-grid");
        this.count = 0;
        this.disabled = false;
    },
    async clickTile(tile) {
        this.playNote(tile);
        if(tile == this.generatedSequence[this.count]){
            if(this.count + 1 == this.generatedSequence.length){
                this.addPointerEvents("tile-grid");
                await this.showText();
                this.message = this.messages[this.generateRandArrIndex(this.messages)];
                this.score = this.generatedSequence.length
                this.disabled = true;
                this.playSequence();
            } else {
                this.count++;
            }
        } else {
            this.updateHighScore();
            this.generatedSequence = []
            this.disabled = true;
            this.$emit('togglePlayStarted');
            this.isPlaying = false;
        }
    },
    buildTiles() {
        this.tiles = [];
        for (let index = 0; index < this.numberOfTiles; index++) {
            this.tiles[index] = index+1;           
        }
    },
    async showText(){
        this.showGameMessage = true;
        await this.sleep(1200);
        this.showGameMessage = false;
    },
    updateHighScore() {
        if(this.score > this.$props.highScore){
            this.$emit('updateHighScore', this.score);
        }
    },
    sleep(ms) {
     return new Promise((resolve) => {
        setTimeout(resolve, ms);
     });
    },
    playNote(tile) {
        if(this.sound){
            synth.triggerAttackRelease(this.notes[tile-1], "5n");
        }
    },
    soundToggle() {
        this.$emit('soundToggle');
    }, 
     generateRandArrIndex(arr) {
      let i = Math.floor(Math.random() * arr.length)
      return i;
  }, 
  addPointerEvents(id) {
    let element = document.getElementById(id);
    element.classList.add('pointer-events-none');
  }, 
  removePointerEvents(id) {
    let element = document.getElementById(id);
    element.classList.remove('pointer-events-none');
  }
 
  }
}
</script>
 
<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.fade-enter-active, .fade-leave-active {
  transition: opacity .3s;
}
.fade-enter, .fade-leave-to /* .fade-leave-active below version 2.1.8 */ {
  opacity: 0;
}
</style>
 
