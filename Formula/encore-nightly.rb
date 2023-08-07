class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230807"
    checksums = {
        "darwin_arm64" => "e67f78309e68c49216995424d29d7a04bc3a4bf234aa5956501779695ae5015b",
        "darwin_amd64" => "b49deee3a7ea5235c044f6ba391b8064c6219ffcb5053758e694f95cb83f1661",
        "linux_arm64"  => "188fa80d6092663f863b63df4df4953647c8d54e65fd652b9d455223ed4df41c",
        "linux_amd64"  => "7f6145a608f753240a7ad5f292de50632cc1437b300e9a2f64f6232aa56753e4",
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
