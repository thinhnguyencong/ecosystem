<template>
    <div class="notice--check" >
        <input :id="id" type="checkbox" :checked="isChecked">
        <label :for="id" class="label-notice">{{ label }}</label>
    </div>
</template>

<script>
export default {
    name: "NotificationCheckbox",
    props: {
        id: String,
        label: String,
        isChecked: Boolean
    }
};
</script>

<style lang="scss" scoped>
@import "@/assets/style/_reset.scss";
@import "@/assets/style/_global.scss";
@import "@/assets/style/main.scss";
.label-notice {
    font-weight: 500;
    font-size: 14px;
    color: var(--text-color-title);
}
.notice--check {
    display: grid;
    gap: 16px 0;
}
</style>