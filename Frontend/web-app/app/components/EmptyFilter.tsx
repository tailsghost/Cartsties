"use client"

import { useParamsStore } from "@/hooks/useParamsStore";
import Heading from "./Heading";
import { Button } from "flowbite-react";
import { signIn } from "next-auth/react";

type Props = {
    title?: string;
    subtitle?: string;
    showReser?: boolean;
    showLogin?: boolean;
    callbackUrl?: string;
}

export default function EmptyFilter({
    title = "Нет совпадений",
    subtitle = "Попробуйте изменить параметры фильтра",
    showReser,
    showLogin,
    callbackUrl
}: Props) {

    const reset = useParamsStore(state => state.reset);

  return (
    <div className="h-[40vh] flex flex-col gap-2 justify-center items-center shadow-lg">
        <Heading title={title} subtitle={subtitle} center/>
        <div className="mt-4">
            {showReser && (
                <Button outline onClick={reset}>Сбросить фильтр</Button>
            )}
            {showLogin && (
                <Button outline onClick={() => signIn("id-server", {callbackUrl})}>Вход в систему</Button>
            )}
        </div>
    </div>
  )
}
