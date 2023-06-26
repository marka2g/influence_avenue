defmodule InfluenceAvenue.CsvStreamer do
  @moduledoc """
  This is the NimbleCSV Parser

  Usage:
    iex> CsvStreamer.parse_donations("/priv/static/files/bod_fortune_500_DIME_cont_records.csv")
  """

  alias InfluenceAvenue.Repo
  alias InfluenceAvenue.Donations.Donation

  def parse_donations(file_path) do
    NimbleCSV.define(DonationsParser, separator: ",", escape: "\"")

    File.cwd!()
    |> Path.join(file_path)
    |> File.stream!()
    |> DonationsParser.parse_stream()
    |> Stream.map(fn [
                       dime_cid,
                       ticker,
                       corpname,
                       _cfscore,
                       cycle,
                       transaction_id,
                       transaction_type,
                       amount,
                       date,
                       contributor_name,
                       contributor_lname,
                       contributor_fname,
                       contributor_mname,
                       _contributor_suffix,
                       contributor_title,
                       contributor_occupation,
                       _contributor_employer,
                       _contributor_address,
                       contributor_city,
                       contributor_state,
                       contributor_zip_code,
                       latitude,
                       longitude,
                       dime_rid,
                       recipient_name,
                       recipient_party
                     ] ->
      donation = %Donation{
        corpname: :binary.copy(corpname),
        cycle: :binary.copy(cycle) |> cast_to_int(),
        amount: :binary.copy(amount) |> cast_to_int(),
        date: :binary.copy(date),
        recipient_name: :binary.copy(recipient_name),
        recipient_party: :binary.copy(recipient_party),
        contributor_name: :binary.copy(contributor_name),
        contributor_occupation: :binary.copy(contributor_occupation),
        more: %{
          ticker: :binary.copy(ticker),
          dime_cid: :binary.copy(dime_cid),
          transaction_id: :binary.copy(transaction_id),
          transaction_type: :binary.copy(transaction_type),
          dime_rid: :binary.copy(dime_rid),
          contributor_fname: :binary.copy(contributor_fname),
          contributor_lname: :binary.copy(contributor_lname),
          contributor_mname: :binary.copy(contributor_mname),
          contributor_title: :binary.copy(contributor_title),
          contributor_city: :binary.copy(contributor_city),
          contributor_state: :binary.copy(contributor_state),
          contributor_zip_code: :binary.copy(contributor_zip_code),
          latitude: latitude |> to_string() |> :binary.copy(),
          longitude: longitude |> to_string() |> :binary.copy()
        }
      }

      if donation.amount >= 1, do: donation |> Repo.insert!()
    end)
    |> Stream.run()
  end

  defp cast_to_int(str) do
    {one, _two} = Integer.parse(str)
    one
  end
end
