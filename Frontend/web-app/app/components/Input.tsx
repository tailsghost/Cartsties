import { Flowbite, Label, TextInput } from "flowbite-react";
import { UseControllerProps, useController } from "react-hook-form";
import { customThemeInput } from "../customStyle/CustomThemeInput";

type Props = {
  label: string;
  type?: string;
  showLabel?: string;
} & UseControllerProps;

export default function Input(props: Props) {
  const { fieldState, field } = useController({ ...props, defaultValue: "" });

  return (
    <div className="mb-3">
      {props.showLabel && (
        <div className="mb-2 block">
          <Label htmlFor={field.name} value={props.label} />
        </div>
      )}
      <Flowbite theme={{ theme: customThemeInput }}>
      <TextInput
        {...props}
        {...field}
        type={props.type || "text"}
        placeholder={props.label}
        color={
          fieldState.error ? "failure" : !fieldState.isDirty ? "" : "success"
        }
        helperText={fieldState.error?.message}
      />
      </Flowbite>
    </div>
  );
}
