# InfluenceAvenue

## The Dataset Source - `dataverse.harvard.edu` 
[Replication Data for: Avenues of Influence: On the Political Expenditures of Corporations and Their Directors and Executives](https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/6R1HAS#)

---

## The Query API
```elixir
# Counts

# total count of donations in db
iex> total_count = Donations.total_count() #=> 313_914

# Individual Record Counts
# direct to dem
iex> Donations.queryable(%{recipient_party: "100", limit: total_count}) 
...> |> Donations.total_query_count # => 81026

# direct to repub
iex> Donations.queryable(%{recipient_party: "200", limit: total_count}) 
...> |> Donations.total_query_count #=> 104256

#<><><><><><><><><><><><><><><><>
# Sort By - cycle, amount, corpname, recipient_name, recipient_party

# amount - whoa, Charlie Munger
iex> Donations.queryable(%{sort_by: :amount, sort_dir: :desc, limit: 20}) 
...> |> Donations.fetch_records()

# cycle(election year)
iex> Donations.queryable(%{sort_by: :cycle, sort_dir: :desc, limit: 20}) 
...> |> Donations.fetch_records()

# corpname
iex> Donations.queryable(%{sort_by: :corpname, sort_dir: :desc, limit: 20}) 
...> |> Donations.fetch_records()

# recipient_name
iex> Donations.queryable(%{sort_by: :recipient_name, sort_dir: :asc, limit: 20})
...> |> Donations.fetch_records()

# recipient_party
iex> Donations.queryable(%{sort_by: :recipient_party, sort_dir: :asc, limit: 20})
...> |> Donations.fetch_records()

#<><><><><><><><><><><><><><><><>
# Filters - filter_by_cycle, filter_by_corpname, filter_by_recipient_name & filter_by_recipient_party

# Cycle(Election Year)
iex> Donations.queryable(%{limit: 20, cycle: 2000}) 
...> |> Donations.fetch_records()

## Fuzzy Search Filters
# Corporation Name
iex> Donations.queryable(%{limit: 20, corpname: "Starbucks"}) 
...> |> Donations.fetch_records()

# Candidate Name
# bush
iex> Donations.queryable(%{limit: 400_000, recipient_name: "Bush, George"})
...> |> Donations.total_query_count # => 3949
iex> Donations.queryable(%{limit: 20, recipient_name: "Bush, George"})
...> |> Donations.fetch_records()

# obama
iex> Donations.queryable(%{limit: 400_000, recipient_name: "Obama"})
...> |> Donations.total_query_count # => 4374
iex> Donations.queryable(%{limit: 20, recipient_name: "Obama"})
...> |> Donations.fetch_records()

# Candidate Party
# direct to dems
iex> Donations.queryable(%{recipient_party: "100", limit: total_count})
...> |> Donations.fetch_records()
#iex> Donations.queryable(%{recipient_party: "dem", limit: total_count})

# direct to repub
iex> Donations.queryable(%{recipient_party: "200", limit: total_count})
...> |> Donations.fetch_records()
# iex> Donations.queryable(%{recipient_party: "repub", limit: 313_914})

#<><><><><><><><><><><><><><><><>
# Infinity Scroll


```

---
To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Helpful Links
[Fly.io Github Workflow](https://fly.io/phoenix-files/github-actions-for-elixir-ci/)


## Fly Commands
```bash
$ fly ssh issue --agent
$ fly ssh console
$ /app/bin/influence_avenue remote

iex> alias InfluenceAvenue.CsvStreamer
```



## Learn more

  * [Phoenix Fly.io Deploy Docs](https://github.com/phoenixframework/phoenix/blob/main/guides/deployment/fly.md)
  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
