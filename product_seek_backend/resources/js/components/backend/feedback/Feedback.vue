<template>
<div class="row">
	<loader v-if='loading'></loader>
	<div class="col-md-12">

		<div class="card mt-2">
			<div class="card-header">
				<h4>Feedback</h4>
			</div>
			<div class="card-bodytable-responsive p-0">
				<table class="table table-hover text-nowrap">
          <thead>
            <tr>
              <th>Feedback</th>
              <th>Customer</th>
              <th>Actions</th>
            </tr>
          </thead>
          <tbody>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>
</template>
<script>
	export default{
		name:'feedback',
		props:['feedback_url'],

		data(){
			return{
				loading:true,
				feedback:{},
			}
		},


		methods:{

			loadFeedbacks(){

				axios.get(this.feedback_url+'/paginated_feedbacks').then(({data})=>{
					this.feedback=data
					this.loading=false
				})
			}

		},

		created(){
			this.loadFeedbacks()
		}
	}
</script>