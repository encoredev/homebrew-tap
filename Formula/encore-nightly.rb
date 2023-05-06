class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230506"
    checksums = {
        "darwin_arm64" => "00e92db9a6fb13c6cf565ed298f0403acccafd1b4aede8a06f3c2306dd28aa92",
        "darwin_amd64" => "bf48c519c033fc39f5f13e10a0942298c0bfc0513bbfc63bf1c42444fe282c9f",
        "linux_arm64"  => "deb2b2117ffd75f22c8b33f568e6c4838f53269c68822e60c3a9f9e2ca6c04bf",
        "linux_amd64"  => "bb329e5416f0dcf006687afc5aa69c48d010fc2d3179045fca768c98b3bfaff9",
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
