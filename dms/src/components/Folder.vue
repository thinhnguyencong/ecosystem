<template>
    <div>
      <span class="material-icons">folder</span>
      <h4 class="truncate">{{name}}</h4>
    </div>
</template>
<script>

export default {
  props: {
    id: String,
    name: String
  },
  data() {
    return {
    }
  },

   methods: {
    handleAccessFolder() {
      this.$router.push('/folder/' + this.id )
    },
   }
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