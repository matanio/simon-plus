<template>
  <div class="bg-white grid grid-rows-8 shadow-xl rounded-lg w-full md:w-3/4  m-auto p-4 slide-in-global">
    <ul   id="toolbar" class="flex border-b-4">
      <li class="grid -mb-1 mr-1">
        <a
          @click="handleToolClick($event)"
          id="play"
          class="border-gray-200 bg-white inline-block border-l-4 border-t-4 border-r-4 rounded-t py-2 px-4"
          ><svg
            xmlns="http://www.w3.org/2000/svg"
            class="h-8 w-8 text-gray-400 pointer-events-none"
            fill="none"
            viewBox="0 0 24 24"
            stroke="currentColor"
          >
            <path
              stroke-linecap="round"
              stroke-linejoin="round"
              stroke-width="2"
              d="M14.752 11.168l-3.197-2.132A1 1 0 0010 9.87v4.263a1 1 0 001.555.832l3.197-2.132a1 1 0 000-1.664z"
            />
            <path
              stroke-linecap="round"
              stroke-linejoin="round"
              stroke-width="2"
              d="M21 12a9 9 0 11-18 0 9 9 0 0118 0z"
            /></svg
        ></a>
      </li>
      <li  class="grid mr-1">
        <a
          @click="handleToolClick($event)"
          id="settings"
          class="rounded-t border-l-4 border-t-4 border-r-4 border-transparent bg-white inline-block py-2 px-4"
        >
          <svg
            xmlns="http://www.w3.org/2000/svg"
            class="h-8 w-8 text-gray-400 pointer-events-none"
            fill="none"
            viewBox="0 0 24 24"
            stroke="currentColor"
          >
            <path
              stroke-linecap="round"
              stroke-linejoin="round"
              stroke-width="2"
              d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z"
            />
            <path
              stroke-linecap="round"
              stroke-linejoin="round"
              stroke-width="2"
              d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"
            /></svg
        ></a>
      </li>
      <li class="grid mr-1">
        <a
          id="about"
          @click="handleToolClick($event)"
          class="rounded-t border-transparent border-l-4 border-t-4 border-r-4 bg-white inline-block py-2 px-4 text-blue-500 hover:text-blue-800 font-semibold"
          ><svg
            xmlns="http://www.w3.org/2000/svg"
            class="h-8 w-8 text-gray-400 pointer-events-none"
            fill="none"
            viewBox="0 0 24 24"
            stroke="currentColor"
          >
            <path
              stroke-linecap="round"
              stroke-linejoin="round"
              stroke-width="2"
              d="M8.228 9c.549-1.165 2.03-2 3.772-2 2.21 0 4 1.343 4 3 0 1.4-1.278 2.575-3.006 2.907-.542.104-.994.54-.994 1.093m0 3h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"
            /></svg
        ></a>
      </li>
    </ul>
    <div
      class="row-span-8 rounded-bl rounded-br border-l-4 border-b-4 border-r-4"
    >
      <div v-if="currentTabId == 'play'" class="p-3 mt-2 ml-2 text-center">
          <Game v-on:updateHighScore="updateHighScore" :highScore="this.highScore" :sound="this.isSoundEnabled" v-on:soundToggle="this.isSoundEnabled = !this.isSoundEnabled" v-on:togglePlayStarted="togglePlayStarted()" :tileNum="this.numberOfTiles" />
      </div>
      <div
        v-if="currentTabId == 'settings'"
        class="p-3 mt-2 ml-2 grid grid-rows-8 gap-2"
      >
        <h1 class="mb-4 text-2xl font-bold">Settings ⚙️</h1>
        <div class="border-b">
          <div class="flex items-center justify-left pb-2">
            <label class="font-bold mr-2" for="mode">MODE:</label>
            <select name="mode" v-model="numberOfTiles">
              <option value="4">Easy - 4</option>
              <option value="6">Medium - 6</option>
              <option value="8">Hard- 8</option>
            </select>
          </div>

          <p class="-mt-1 mb-2 text-gray-400 text-sm">
            The game will be played with {{ this.numberOfTiles }} tiles. The
            higher the number of tiles, the more complicated the sequence is,
            and the harder it can be to remember!
          </p>
        </div>

        <div class="border-b">
          <div class="flex items-center justify-left font-bold">
            SOUND:
            <Switch
              :isChecked="this.isSoundEnabled"
              v-on:checked="toggleSoundEnabled()"
            />
          </div>
          <p class="-mt-1 mb-2 text-gray-400 text-sm">
            <span v-if="this.isSoundEnabled">
              Every time a color flashes, a sound will play. You can customise
              the sound of the instrument below.
            </span>
            <span v-else>
              When a color flashes, no sound will play. This adds an extra
              challenge to the game!
            </span>
          </p>
        </div>

        <div v-if="this.isSoundEnabled">
          <div class="flex items-center justify-left pb-2">
            <label class="font-bold mr-2" for="instrument">INSTRUMENT:</label>
            <select
              name="instrument"
              @change="changeInstrument()"
              v-model="this.instrumentIndex"
            >
              <option value="0">Synth 🎹</option>
              <option value="1" disabled>More to come..! 🎸🎻</option>
            </select>
          </div>
        </div>
      </div>
      <div v-if="currentTabId == 'about'" class="p-3 mt-2 ml-2 text-justify">
        <h1 class="mb-4 text-2xl font-bold">Hello! 👋</h1>
        <p>
          My name is Matan, and I'm a Software Engineer in-the-making (I'm still
          studying).
        </p>
        <br />
        <p>
          <span class="font-bold">Simon+</span> is based on the popular
          sequential memory game of the same name. This version just adds some
          extra cool stuff but is mostly a personal project which is in no way
          affiliated with the official game.
        </p>
        <br />
        <p>
          Do note that this game is sort of my first experiment with the Vue.js
          framework - so
          <span class="font-bold">any feedback/guidance</span> would be greatly
          appreciated.
        </p>
      </div>
    </div>
  </div>
</template>

<script>
import Switch from "./Switch.vue";
import Game from "./Game.vue";

export default {
  name: "MainMenu",
  components: {
    Switch,
    Game,
  },
  data() {
    return {
      currentTabId: "play",
      isSoundEnabled: true,
      numberOfTiles: 4,
      instrumentIndex: 0,
      instrumentEmojis: ["🎹"],
      isPlaying: false,
      highScore: 0,
    };
  },
  methods: {
    handleToolClick(event) {
      let prevTab = document.getElementById(this.currentTabId);
      let tabListItem = prevTab.parentElement;
      tabListItem.classList.remove("-mb-1");
      prevTab.classList.remove("border-gray-200");
      prevTab.classList.add("border-transparent");
      let clickedTool = event.target;
      let clickedToolListParent = clickedTool.parentElement;
      clickedTool.classList.add("border-gray-200");
      clickedTool.classList.remove("border-transparent");
      clickedToolListParent.classList.add("-mb-1");
      this.currentTabId = clickedTool.id;     
    },
    togglePlayStarted() {
    let toolbar = document.getElementById("toolbar");
    this.isPlaying = !this.isPlaying;
    if(this.isPlaying){
        toolbar.classList.add('pointer-events-none')
    } else {
        toolbar.classList.remove('pointer-events-none')
    }

    },
    updateHighScore(score) {
        this.highScore = score;
    },
    toggleSoundEnabled() {
      this.isSoundEnabled = !this.isSoundEnabled;
    },
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped></style>
