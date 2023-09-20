class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230920"
    checksums = {
        "darwin_arm64" => "ae0a15ed8bfbe6fa84525271ba4ed94929d4bb58069e64ca224dc9a708f27d8f",
        "darwin_amd64" => "65e7dc763a591a2065aa055c5bbec97ff9add76778bf8170b8d830de25291924",
        "linux_arm64"  => "e0165740d634d55075ad69ff04ebc78f1fed46dc65738cc8c69d316aba7c86ba",
        "linux_amd64"  => "70f9db9745628b6f3985710e67ddd67e4525f111269da7f7f5d3b8305c908a5e",
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
