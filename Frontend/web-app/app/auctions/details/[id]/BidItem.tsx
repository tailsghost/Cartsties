import { numberWithCommas } from "@/app/lib/numberWithComma";
import { Bid } from "@/types";
import { format } from "date-fns";

type Props = {
  bid: Bid;
};

export default function BidItem({ bid }: Props) {
  function getBidInfo() {
    let bgColor = "";
    let text = "";
    switch (bid.bidStatus) {
      case "Accepted":
        bgColor = "bg-green-200";
        text = "Ставка принята";
        break;
      case "AcceptedBelowReserve":
        bgColor = "bg-amber-500";
        text = "Ставка ниже начальной цены владельца";
        break;
      case "TooLow":
        bgColor = "bg-red-200";
        text = "Ставка ниже минимума";
        break;
      default:
        bgColor = "bg-red-200";
        text = "Аукцион завершен. Ставки не принимаются";
    }

    return { bgColor, text };
  }

  return (
    <div
      className={`
    border-gray-300 border-2 px-3 py-2 rounded-lg
    flex justify-between items-center mb-2
    ${getBidInfo().bgColor}
    `}
    >
      <div className="flex flex-col">
        <span>Участник: {bid.bidder}</span>
        <span className="text-gray-700 text-sm">
          Время: {format(new Date(bid.bidTime, ), "dd MMM yyyy h:mm a")}
        </span>
      </div>
      <div className="flex flex-col text-right">
        <div className="text-xl font-semibold">${numberWithCommas(bid.amount)}</div>
        <div className="flex flex-row items-center">
          <span>{getBidInfo().text}</span>
        </div>
      </div>
    </div>
  );
}
