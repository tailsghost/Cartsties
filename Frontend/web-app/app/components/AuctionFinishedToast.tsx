import { Auction, AuctionFinished } from "@/types";
import Link from "next/link";
import Image from "next/image";
import { numberWithCommas } from "../lib/numberWithComma";

type Props = {
  finishedAuction: AuctionFinished;
  auction: Auction;
};

export default function AuctionFinishedToast({
  auction,
  finishedAuction,
}: Props) {
  console.log("Я тут")
  return (
    <Link
      href={`/auctions/details/${auction.id}`}
      className="flex flex-col items-center"
    >
      <div className="flex flex-row items-center gap-2">
        <Image
          src={auction.imageUrl}
          alt="image"
          height={80}
          width={80}
          className="rounded-lg w-auto h-auto"
        />
        <div className="flex flex-col">
          <span>
            Аукцион {auction.make} {auction.model} завершен!
            {finishedAuction.itemSold && finishedAuction.amount ? (
              <p>Поздравляем победителя {finishedAuction.winner} аукциона, стоимость $${numberWithCommas(finishedAuction.amount)}</p>
            ) : <p>Автомобиль не был продан</p>}
          </span>
        </div>
      </div>
    </Link>
  );
}
