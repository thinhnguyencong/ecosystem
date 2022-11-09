<template>
  <div class="about">
    <div class="card app-card" style="width: 18rem;">
      <img :src="logoURL" class="card-img-top"  alt="Vue" />  
      <div class="card-body">
        <a href="/" class="card-title stretched-link">Document Management System</a>
      </div>
    </div>
  </div>
</template>
<script setup>

import logoURL from '../assets/img-doc.png'

</script>
<style>
.app-card:hover {
  background-color: rgb(222, 222, 222);
}
</style>
