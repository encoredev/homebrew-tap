class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.52.2"
    checksums = {
        "darwin_arm64" => "9cb6f028d93308ad7049e55d6ad452406a304bf4ce383859df55c270f0aebd7e",
        "darwin_amd64" => "5873460a00fad9b92398b23d1ae314a551a888b03f802ac80f15fa90ca22de5c",
        "linux_arm64"  => "68dca1e1198d2df03e062a999e7e2bbb23499aec14da9f26bd909f8bc24cf0e3",
        "linux_amd64"  => "fb0616f06a04a348adb834ff13c7c0e8bac0cd54ed3112285d12ccffe4e1fb4d",
    }

    arch = "arm64"
    platform = "darwin"
    on_intel do
        arch = "amd64"
    end
    on_linux do
        platform = "linux"
    end

    url "https://d2f391esomvqpi.cloudfront.net/encore-#{release_version}-#{platform}_#{arch}.tar.gz"
    version release_version
    sha256 checksums["#{platform}_#{arch}"]

    def install
        libexec.install Dir["*"]

        bin.install_symlink Dir[libexec/"bin/*"]


        # Install bash completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "bash")
        (bash_completion/"encore").write output

        # Install zsh completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "zsh")
        (zsh_completion/"_encore").write output

        # Install fish completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "fish")
        (fish_completion/"encore.fish").write output
    end

    test do
        system "#{bin}/encore", "check"
    end
end
