import { useParamsStore } from "@/hooks/useParamsStore";
import Heading from "./Heading";
import { Button } from "flowbite-react";

type Props = {
    title?: string;
    subtitle?: string;
    showReser?: boolean;
}

export default function EmptyFilter({
    title = "Нет совпадений",
    subtitle = "Попробуйте изменить параметры фильтра",
    showReser
}: Props) {

    const reset = useParamsStore(state => state.reset);

  return (
    <div className="h-[40vh] flex flex-col gap-2 justify-center items-center shadow-lg">
        <Heading title={title} subtitle={subtitle} center/>
        <div className="mt-4">
            {showReser && (
                <Button outline onClick={reset}>Сбросить фильтр</Button>
            )}
        </div>
    </div>
  )
}
