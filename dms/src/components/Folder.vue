<template>
    <div>
      <span v-if="folder.owner?._id === authState.user._id" class="material-icons">folder</span>
      <span v-else class="material-icons">folder_shared</span>
      <h4 class="truncate">{{folder.name}}</h4>
    </div>
</template>
<script>

export default {
  props: {
    folder: Object,
  },
  data() {
    return {
    }
  },

  methods: {
    handleAccessFolder() {
      this.$router.push('/folder/' + this.folder._id )
    },
  },
  computed: {
    authState() { return this.$store.state.auth; },
  },
}
</script>
<style scoped>
.truncate {
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}
.material-icons{
    color: #00A8FF;
    height: 55px;
    margin-bottom: 20px;
    font-size: 55px;
    display: block;
    line-height: 54px;
    cursor: pointer;
} 
</style>