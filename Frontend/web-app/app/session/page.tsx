import React from 'react'
import Heading from '../components/Heading';
import { getServerSession } from 'next-auth';
import { authOptions } from '../api/auth/[...nextauth]/route';
import AuthTest from './AuthTest';
import { getTokenWorkaround } from '../actions/authActions';

export async function getSession() {
    return await getServerSession(authOptions);
}

export default async function Session() {
    const session = await getSession();
    const token = await getTokenWorkaround();

  return (
    <div>
        <Heading title="Панель управления пользователя"/>

        <div className='bg-blue-200 border-2 border-blue-500'>
            <h3 className='text-lg'>
                Информация о пользователе
            </h3>
            <pre>{JSON.stringify(session, null, 2)}</pre>
        </div>
        <div className='mt-4'>
            <AuthTest/>
        </div>
        <div className='bg-green-200 border-2 border-blue-500 mt-4'>
            <h3 className='text-lg'>
                Информация о Токене
            </h3>
            <pre className='overflow-auto'>{JSON.stringify(token, null, 2)}</pre>
        </div>
    </div>
  )
}
