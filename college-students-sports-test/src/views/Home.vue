<template>
	<div class="home">
		
		<FormList></FormList>

	</div>
</template>

<script>
// @ is an alias to /src
import FormList from '@/components/FormList.vue'
export default {
	name: 'Home',
	components: {
		FormList
	},
	data() {
		return {
			
		}
	},
	created() {
		
	},
	methods: {
		
	},
}
</script>

<style>
body{
	background-color: #FFFFFF;
}
</style>