import { Button } from "flowbite-react";
import Link from "next/link";

type Props ={
    id: string;
}

export default function EditButton({id} : Props) {
  return (
    <Button outline>
        <Link href={`/auctions/update/${id}`}>Обновить аукцион</Link>
    </Button>
  )
}
