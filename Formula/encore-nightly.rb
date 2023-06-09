class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230609"
    checksums = {
        "darwin_arm64" => "446895ac4ffc74b01a738a3ed1786f156a0fe8e215b9f46b1913c439b96516a6",
        "darwin_amd64" => "04ba69ae35f41846a16e87a36246d942bcb013eabcdd6746a6a2eaa3e9d1f359",
        "linux_arm64"  => "0f3c874121e875d1ba49b9dee6d5e01e3fe21ec5bf421984d9b28d5eabbcc219",
        "linux_amd64"  => "0a27d9a5c1aaffab9ec4ad9a8983cc842b5372806e6934a38ea03dec12ff1d81",
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
