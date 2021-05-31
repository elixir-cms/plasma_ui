defmodule PlasmaUiWeb.Helpers.DateTime do
  @moduledoc """
  TODO
  """

  def humanize_iso8601(datetime_string) do
    {:ok, timestamp, 0} = DateTime.from_iso8601(datetime_string)
    day = (timestamp.day > 9 && "#{timestamp.day}") || "0#{timestamp.day}"
    month = (timestamp.month > 9 && "#{timestamp.month}") || "0#{timestamp.month}"
    year = timestamp.year
    hour = (timestamp.hour > 9 && "#{timestamp.hour}") || "0#{timestamp.hour}"
    minute = (timestamp.minute > 9 && "#{timestamp.minute}") || "0#{timestamp.minute}"
    "#{year}-#{month}-#{day} @ #{hour}:#{minute} UTC"
  end
end
