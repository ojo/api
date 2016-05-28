import Ember from 'ember';

var items = [
{
  type: 'blog',
  content: {
    body: 'this is a blog post'
  }
}, 
{
  type: 'tweet',
  content: {
    text: 'this is the tweet'
  }
}, 
{
  type: 'instagram',
  content: {
    image: "https://pbs.twimg.com/media/Bm54nBCCYAACwBi.jpg"
  }
}];

export default Ember.Route.extend({
  model() {
    return items;
  }
});
