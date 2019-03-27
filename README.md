Datamuse API Call script (Ruby)
========================

Usage (from terminal):
```ruby
ruby datamuse.rb <query> <keyword> <query> <keyword> # etc...
```
*Requires a minimum of two arguments*

**_NOTE:_** Datamuse API response will be written to the file specified in `config.yml` as JSON.

### Options:
- `related`: Words related to `keyword`
- `synonym`: Synonyms of `keyword`
- `antonym`: Antonyms of `keyword`
- `sound`: Words that sound similar to `keyword`
- `rhyme`: Words that rhyme with `keyword`
- `describe`: Adjectives often used to describe `keyword`
- `describe_by`: Nouns often described by `keyword`
- `prefix`: Words that start with `keyword`
- `suffix`: Words that end with `keyword`
- `spelling`: Spelled like the given expression (`?`= wildcard,`*`= multiple wildcard)(ex. `t??e`, `*graphy`)
- `follow`: Words that often follow `keyword`
- `precede`: Words that often precede `keyword`
- `general`: Words that are more general than `keyword`
- `specific`: Words that are more specific than `keyword`
- `comprise`: Words that `keyword` comprises
- `part`: Parts of a `keyword`
- `topic`/`sort`: Sort results by a topic `keyword`
- `trigger`/`associated`: Words triggered by `keyword`
- `homophone`: Homophones of `keyword`
- `max`: Set the maximum number of results to receive from the API call

### Examples
Words related to fish and start with "tr"
```ruby
ruby datamuse.rb related fish prefix t
# => [ "trout", "tributaries", "troll", "tripletail", "truttaceous", ...] >> datamuse_output.json
```
Words that rhyme with cake, related to dessert
```ruby
ruby datamuse.rb rhyme cake related dessert
# => [ "steak", "bake", "pancake", "cupcake", "cheesecake", ...] >> datamuse_output.json
```
Adjectives used to describe fruit, sorted by color
```ruby
ruby datamuse.rb describe fruit sort color
# => ["colored", "purple", "red", "yellow", "luscious", "scarlet", ...] >> datamuse_output.json
```
