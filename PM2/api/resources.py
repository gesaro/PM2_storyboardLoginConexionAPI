from tastypie.resources import ModelResource
from api.models import Post
from tastypie.authorization import Authorization

class PostResource(ModelResource):
    class Meta:
        queryset = Post.objects.all()
        resource_name = 'post'

        authorization = Authorization()	
