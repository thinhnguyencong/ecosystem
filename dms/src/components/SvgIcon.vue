<template>
    <object :data="src" type="image/svg+xml" ></object>
</template>

<script>
export default {
    props: {
        src: {
            type: String,
            required: true
        }
    }

};
</script>
