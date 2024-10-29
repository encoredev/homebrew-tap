class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.43.7"
    checksums = {
        "darwin_arm64" => "5b998504b5a17e91406cbe6710fb94219429643b3630c1b19a41080c4dc04e16",
        "darwin_amd64" => "5f998943863fc551c5a1e179a8ef496fa7a90c62a8605887e40754b37447db94",
        "linux_arm64"  => "a3ac2413d82b1af0b8d0af9128b5c34c5c7fe8f73358b90f1b7a0db40bb45987",
        "linux_amd64"  => "1a5c53e6c57c79ad1801ea1a6d85f12bb3b88607e507586c4fa5268da642e621",
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
