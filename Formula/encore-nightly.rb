class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230122"
    checksums = {
        "darwin_arm64" => "19a8bc845be30b561b590efa1b0d3a140eef7b4dc1fb51cd99fcf99a6ea17306",
        "darwin_amd64" => "92b5259d22d900124379df599e34525100f650bfcbd28f6d8ea48e2a24e227aa",
        "linux_arm64"  => "35e6f885c7bda4f33da4f4611fd48886e5919cc28705b843fe9df3fa3f7c8397",
        "linux_amd64"  => "06131cf1e2184110baad48b07b35f046bed1c83dee0fef98605307c037c9a365",
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
