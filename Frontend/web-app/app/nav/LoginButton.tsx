"use client"

import { Button } from 'flowbite-react'
import { signIn } from 'next-auth/react'
import { Flowbite } from "flowbite-react";
import { customThemeButton } from '../customStyle/CustomThemeButton';

export default function LoginButton() {
  return (
    <Flowbite theme={{ theme: customThemeButton }}>
    <Button outline onClick={() => signIn("id-server", {callbackUrl: "/"}, {prompt: "login"})}>Вход в систему</Button>
    </Flowbite>
  )
}
